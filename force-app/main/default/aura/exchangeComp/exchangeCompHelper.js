({
    //new record is created by calling the apex method and put in the data attribute
    fetchData: function (component, event, helper) {
        //bring the component and put it in variable
        var action = component.get("c.exchangeObject");
        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var data = response.getReturnValue();
                component.set('v.data', data);
            }
        });
        $A.enqueueAction(action);
    },
})