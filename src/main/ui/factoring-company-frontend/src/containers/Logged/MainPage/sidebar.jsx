import React from 'react';
import {
  CDBSidebar, CDBSidebarContent, CDBSidebarFooter, CDBSidebarHeader, CDBSidebarMenu, CDBSidebarMenuItem} from 'cdbreact';
import { NavLink } from 'react-router-dom';
import { Marginer } from '../../../components/marginer';
import { BoxArrowRight } from 'react-bootstrap-icons';

const Sidebar = () => {
  return (
    <div
      style={{ display: 'flex', height: '100vh', overflow: 'scroll initial' }}
    >
      <CDBSidebar textColor="#fff" backgroundColor="#060053">
        <CDBSidebarHeader prefix={<i className="fa fa-bars fa-large"></i>}>
          <a
            href="/"
            className="text-decoration-none"
            style={{ color: 'inherit', fontSize:"20px" }}>
              Factoring
          </a>
        </CDBSidebarHeader>

        <CDBSidebarContent className="sidebar-content">
          <CDBSidebarMenu>
            <NavLink exact to="/" activeClassName="activeClicked">
              <CDBSidebarMenuItem icon="file-invoice-dollar">Invoices</CDBSidebarMenuItem>
            </NavLink>
            <NavLink exact to="/tables" activeClassName="activeClicked">
              <CDBSidebarMenuItem icon="credit-card">Credit</CDBSidebarMenuItem>
            </NavLink>
            <Marginer direction="vertical" margin={35} />
            <NavLink exact to="/customers" activeClassName="activeClicked">
              <CDBSidebarMenuItem icon="users">Customers</CDBSidebarMenuItem>
            </NavLink>
            <NavLink exact to="/reports" activeClassName="activeClicked">
              <CDBSidebarMenuItem icon="file-signature">Reports</CDBSidebarMenuItem>
            </NavLink>
            <NavLink exact to="/documents" activeClassName="activeClicked">
              <CDBSidebarMenuItem icon="file-alt">Documents</CDBSidebarMenuItem>
            </NavLink>
            <NavLink exact to="/documents" activeClassName="activeClicked">
              <CDBSidebarMenuItem icon="user">Your Profile</CDBSidebarMenuItem>
            </NavLink>
            <NavLink exact to="/documents" activeClassName="activeClicked">
              <CDBSidebarMenuItem icon="exclamation-circle">Help & Contact</CDBSidebarMenuItem>
            </NavLink>
          </CDBSidebarMenu>
        </CDBSidebarContent>

        <CDBSidebarFooter>
          <div class="mb-3">
            <CDBSidebarMenuItem icon="sign-out-alt"><a href="/" class="text-decoration-none" style={{color:"white"}}>Log Out</a></CDBSidebarMenuItem>
          </div>
        </CDBSidebarFooter>
      </CDBSidebar>
    </div>
  );
};

export default Sidebar;