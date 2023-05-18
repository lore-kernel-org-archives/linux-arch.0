Return-Path: <linux-arch-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54044C77B7A
	for <linux-arch@archiver.kernel.org>; Thu, 18 May 2023 01:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjERB4u (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Wed, 17 May 2023 21:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjERB4s (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 May 2023 21:56:48 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CDEE43;
        Wed, 17 May 2023 18:56:33 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QMCgP5x8zzLncJ;
        Thu, 18 May 2023 09:53:37 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 18 May 2023 09:56:30 +0800
Message-ID: <4f664a41-2e74-fd42-289a-b61fb76e6a5f@huawei.com>
Date:   Thu, 18 May 2023 09:56:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v5 RESEND 04/17] mm/ioremap: Define generic_ioremap_prot()
 and generic_iounmap()
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>, <linux-kernel@vger.kernel.org>
CC:     <linux-arch@vger.kernel.org>, <linux-mm@kvack.org>,
        <arnd@arndb.de>, <christophe.leroy@csgroup.eu>,
        <hch@infradead.org>, <agordeev@linux.ibm.com>,
        <schnelle@linux.ibm.com>, <David.Laight@ACULAB.COM>,
        <shorne@gmail.com>, <willy@infradead.org>, <deller@gmx.de>
References: <20230515090848.833045-1-bhe@redhat.com>
 <20230515090848.833045-5-bhe@redhat.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20230515090848.833045-5-bhe@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 2023/5/15 17:08, Baoquan He wrote:
> From: Christophe Leroy <christophe.leroy@csgroup.eu>
> 
> Define a generic version of ioremap_prot() and iounmap() that
> architectures can call after they have performed the necessary
> alteration to parameters and/or necessary verifications.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Signed-off-by: Baoquan He <bhe@redhat.com>

Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>

