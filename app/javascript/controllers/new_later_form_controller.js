// Visit The Stimulus Handbook for more details 
// https://stimulusjs.org/handbook/introduction
// 
// This example controller works with specially annotated HTML like:
//
// <div data-controller="hello">
//   <h1 data-target="hello.output"></h1>
// </div>

import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "title", "image", "description" ]

  checkOgGraph(event) {
    const self = this;
    console.log('event', event.srcElement.value)
    const url = event.srcElement.value;
    Rails.ajax({
      type: "POST", 
      url: "/remind/check_og_graph",
      data: 'url=' + url,
      success: function(response){
        console.log('response', response)
        let title, image, description;
        if(response.open_graph.meta_tags.property['og:title'].length) {
          title = response.open_graph.meta_tags.property['og:title'][0]
          self.titleTarget.textContent = title;
        }
        if(response.open_graph.meta_tags.property['og:description'].length) {
          description = response.open_graph.meta_tags.property['og:description'][0]
          self.descriptionTarget.textContent = description;
        }
        if(response.open_graph.meta_tags.property['og:image'].length) {
          image = response.open_graph.meta_tags.property['og:image'][0]
          self.imageTarget.src = image;
        }
          
        return [title, description, image];
      }
    });
  }
}
