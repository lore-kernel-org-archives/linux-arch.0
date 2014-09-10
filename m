From: Yijing Wang <wangyijing@huawei.com>
Subject: Re: [PATCH v10 07/10] OF: Introduce helper function for getting PCI
 domain_nr
Date: Wed, 10 Sep 2014 09:55:48 +0800
Message-ID: <540FAFA4.1080008@huawei.com>
References: <1410184472-17630-1-git-send-email-Liviu.Dudau@arm.com>
 <1410184472-17630-8-git-send-email-Liviu.Dudau@arm.com>
 <CAL_JsqJi8k1Goc3UmXhuxf9v7=4gJrYG_Di7v574PxS8TsJaXw@mail.gmail.com>
 <20140908145459.GO27864@e106497-lin.cambridge.arm.com>
 <CAL_JsqJdGKDVwJOpPp19OkVPGzR7Zqv3nh+ONHHaYnPLYTYoYg@mail.gmail.com>
 <20140908155931.GP27864@e106497-lin.cambridge.arm.com>
 <540E960D.7080408@huawei.com>
 <20140909084621.GS27864@e106497-lin.cambridge.arm.com>
 <540EC8CB.7010106@huawei.com>
 <CAErSpo4cAfom2=07NYDRfTCdHO22M0v+ueiaZuG6v2Xd18wEnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAErSpo4cAfom2=07NYDRfTCdHO22M0v+ueiaZuG6v2Xd18wEnQ@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Catalin Marinas <Catalin.Marinas@arm.com>, linux-pci <linux-pci@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Liviu Dudau <Liviu.Dudau@arm.com>, Grant Likely <grant.likely@secretlab.ca>, Tanmay Inamdar <tinamdar@apm.com>, linux-arch <linux-arch@vger.kernel.org>, Kukjin Kim <kgene.kim@samsung.com>, Russell King <linux@arm.linux.org.uk>, Jingoo Han <jg1.han@samsung.com>, Jason Gunthorpe <jgunthorpe@obsidianresearch.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Device Tree ML <devicetree@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Will Deacon <Will.Deacon@arm.com>, Rob Herring <robh+dt@kernel.org>, LAKML <linux-arm-kernel@lists.infradead.org>, Sinan Kaya <okaya@codeaurora.org>, LKML <linux-kernel@vger.kernel.org>, Suravee Suthikulanit <suravee.suthikulpanit@amd.com>
List-Id: linux-arch.vger.kernel.org

>> OK. Sorry, I have one last question, because domain will be used to calculate the address used to
>> access PCI hardware config registers. So if DTS file doesn't report the domain, how do we know
>> we would access the right registers when we use the auto increment domain vaule ?
>> Has there a mechanism to make sure system can access the correct registers by the domain ?
> 
> I think you're referring to config access via ECAM (PCIe r3.0, sec
> 7.2.2).  In that case, I don't think the domain should be used to
> compute the memory-mapped configuration address.  Each host bridge is
> in exactly one domain, and each host bridge has an associated ECAM
> area base.  The address calculation uses the bus number, device
> number, function number, and register number to compute an offset into
> the ECAM area.
> 
> So as long as the DT tells you the ECAM information for each host
> bridge, that should be sufficient.  The domain number is then just a
> Linux convenience and is not tied to the platform as it is on ia64.

Hi Bjorn, you are right, thanks for your detailed explanation! :)

Thanks!
Yijing.

> 
> Bjorn
> 
> .
> 


-- 
Thanks!
Yijing
