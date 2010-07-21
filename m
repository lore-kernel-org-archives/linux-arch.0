From: stepanm@codeaurora.org
Subject: Re: [RFC 1/3 v3] mm: iommu: An API to unify IOMMU,
           CPU and device memory management
Date: Tue, 20 Jul 2010 22:18:55 -0700 (PDT)
Message-ID: <5a63b73ff04b72db2930eae4e43e5c5b.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-mm@kvack.org>
Sender: owner-linux-mm@kvack.org
Cc: zpfeffer@codeaurora.org, linux@arm.linux.org.uk, fujita.tomonori@lab.ntt.co.jp, ebiederm@xmission.com, linux-arch@vger.kernel.org, dwalker@codeaurora.org, mel@csn.ul.ie, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, andi@firstfloor.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

> What is the problem about mapping a 1MB buffer with the DMA API?
>
> Possibly, an IOMMU can't find space for 1MB but it's not the problem of
the DMA API.

As you have pointed out, one of the issues is that allocation can fail.
While technically VCMM allocations can fail as well, these allocations ca=
n
be made from one or more memory pools that have been set aside
specifically to be used by devices. Thus, the kernel's normal allocator
will not encroach on the large physically-contiguous chunks (of size 1MB
or even 16MB) that are not easy to get back, and would be forced to deal
with increasing memory pressure in other ways.
Additionally, some of the memory pools may have special properties, such
as being part of on-chip memory with higher performance than regular
memory, and some devices may have special requirements regarding what typ=
e
or memory they need. The VCMM allocator solves the problem in a generic
way by being able to deal with multiple memory pools and supporting
prioritization schemes for which subset of the memory pools is to be used
for each physical allocation.

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum=
.




--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=3Dmailto:"dont@kvack.org"> email@kvack.org </a>
