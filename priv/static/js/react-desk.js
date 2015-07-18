var data = [
  {id: 1, client: "Pete Hunt", status: "entered"},
  {id: 2, client: "Hunt", status: "entered"}
];
var DeskTable = React.createClass({
  render: function() {
    return (  
      <table className="table table-striped table-hover">
        <thead>
          <tr>
            <td>id</td> 
            <td>client</td> 
            <td>status</td> 
            <td>start</td> 
          </tr>
        </thead>
        <tbody>
          <Row data={this.props.data}/>
        </tbody>
      </table>
    );
  }
});


var Row = React.createClass({
  render: function() {
    return (  
      <tr>
        <td>{this.props.id}</td> 
        <td>{this.props.client}</td> 
        <td>{this.props.status}</td> 
        <td><Start id={this.props.id} /></td> 
      </tr>
    );
  }
});


var Start = React.createClass({
  render: function() {
    return (  
      <a className="btn btn-primary btn-xs" target="_blank" href="/chat/{this.props.id}">Start</a>
    );
  }
});

React.render( 
  <DeskTable data={data}/> ,
  document.getElementById('desk-table')
);
