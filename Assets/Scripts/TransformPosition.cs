//Without referencing the position of blueCube or yellowCube,
//edit this script so that redCube (this gameObject) oscillates between
//bluePos and yellowPos so that redCube moves to 3 units above blueCube and 3 units below yellowCube.

using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TransformPosition : MonoBehaviour
{
    // References to blueCube and yellowCube in the scene. redCube is this gameObject.
    public GameObject blueCube;
    public GameObject yellowCube;


    // The positions that redCube will oscillate between.
    public Vector3 bluePos; // this should be 3 units above blueCube in world space.
    public Vector3 yellowPos; // this should be 3 units below yellowCube in world space.


    // Oscillation Speed
    public float speed = 1f;


    // Compute bluePos and yellowPos here
    void computePositions()
    {
        bluePos = blueCube.transform.TransformPoint(Vector3.up * 3);
        yellowPos = yellowCube.transform.TransformPoint(Vector3.down * 3);
    }

    // Update is called once per frame
    void Update()
    {
        computePositions();

        transform.position = Vector3.Lerp(bluePos, yellowPos, Mathf.PingPong(Time.time * speed, 1.0f));
    }
}
