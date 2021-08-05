using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class fractalScript : MonoBehaviour
{
    Material fractalMaterial;
    float timeScalar = 0.1f;


    // Start is called before the first frame update
    void Start()
    {
        fractalMaterial = transform.GetComponent<MeshRenderer>().material;
    }

    // Update is called once per frame
    void Update()
    {
        float cx = -0.1f + 0.655f * Mathf.Cos(timeScalar * Time.time);
        float cy = 0.655f * Mathf.Sin(timeScalar * Time.time);

        Debug.Log(1f / Time.deltaTime);




        fractalMaterial.SetFloat("cX", cx);
        fractalMaterial.SetFloat("cY", cy);
    }
}
