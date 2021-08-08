import React from 'react';
import { Navbar } from '../../components/navbar';
import { PageContainer } from '../../components/pageContainer';
import { FundingSolution } from './fundingSolutions';
import { QuickInfo } from './quickInfo';
import { TopSection } from './topSection';

export function HomePage(props) {
    return <PageContainer>
        <TopSection>
            <Navbar />
        </TopSection>
        <FundingSolution />
        <QuickInfo />
    </PageContainer>
}