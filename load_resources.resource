*** Settings ***
Library    SeleniumLibrary
Library    String
Library    RequestsLibrary
Library    Collections

Resource    resources/Authentication.resource
Resource    resources/Actions.resource
Resource    resources/API.resource

Variables   config.yml