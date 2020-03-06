Return-Path: <SRS0=ZCnS=4X=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbgCFDoL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 5 Mar 2020 22:44:11 -0500
Subject: Re: About commit "io: change inX() to have their own IO barrier
 overrides"
References: <2e80d7bc-32a0-cc40-00a9-8a383a1966c2@huawei.com>
 <c1489f55-369d-2cff-ff36-b10fb5d3ee79@kernel.org>
 <8207cd51-5b94-2f15-de9f-d85c9c385bca@huawei.com>
 <6115fa56-a471-1e9f-edbb-e643fa4e7e11@kernel.org>
 <7c955142-1fcb-d99e-69e4-1e0d3d9eb8c3@huawei.com>
 <CAK8P3a0f9hnKGd6GJ8qFZSu+J-n4fY23TCGxQkmgJaxbpre50Q@mail.gmail.com>
From: Sinan Kaya <okaya@kernel.org>
Message-ID: <90af535f-00ef-c1e3-ec20-aae2bd2a0d88@kernel.org>
Date: Thu, 5 Mar 2020 22:44:08 -0500
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0f9hnKGd6GJ8qFZSu+J-n4fY23TCGxQkmgJaxbpre50Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, John Garry <john.garry@huawei.com>
Cc: "xuwei (O)" <xuwei5@hisilicon.com>, Bjorn Helgaas <bhelgaas@google.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-arch <linux-arch@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>
Message-ID: <20200306034408.pUaSj6Rm_Nons_V6LqEAC8NXMU8IW4eaZ3IB-Jz5ydg@z>

On 3/3/2020 11:40 AM, Arnd Bergmann wrote:
>> -          ret = read##bw(PCI_IOBASE + addr);
>> +          __io_pbr();
>> +          ret = __raw_read##bw(PCI_IOBASE + addr);
>> +          __io_pbr();
> __io_par();
> 

Why do we need to change read##bw above?

read##bw already provides strong ordering guarantees across multiple
architectures.
