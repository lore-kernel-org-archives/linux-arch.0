From: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Subject: Re: [PATCH V3 0/4] mm/debug_vm_pgtable: Add some more tests
Date: Wed, 24 Jun 2020 13:48:08 +0200
Message-ID: <20200624134808.0c460862@thinkpad>
References: <1592192277-8421-1-git-send-email-anshuman.khandual@arm.com>
        <70ddc7dd-b688-b73e-642a-6363178c8cdd@arm.com>
        <20200624110539.GC24934@oc3871087118.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38180 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2403784AbgFXLtK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 24 Jun 2020 07:49:10 -0400
In-Reply-To: <20200624110539.GC24934@oc3871087118.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexander Gordeev <agordeev@linux.ibm.com>, Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-mm@kvack.org, christophe.leroy@c-s.fr, ziy@nvidia.com, Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@linux.ibm.com>, Vineet Gupta <vgupta@synopsys.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, "Kirill A . Shutemov" <kirill@shutemov.name>, Paul Walmsley <paul.walmsley@sifive.com>

On Wed, 24 Jun 2020 13:05:39 +0200
Alexander Gordeev <agordeev@linux.ibm.com> wrote:

> On Wed, Jun 24, 2020 at 08:43:10AM +0530, Anshuman Khandual wrote:
> 
> [...]
> 
> > Hello Gerald/Christophe/Vineet,
> > 
> > It would be really great if you could give this series a quick test
> > on s390/ppc/arc platforms respectively. Thank you.
> 
> That worked for me with the default and debug s390 configurations.
> Would you like to try with some particular options or combinations
> of the options?

It will be enabled automatically on all archs that set
ARCH_HAS_DEBUG_VM_PGTABLE, which we do for s390 unconditionally.
Also, DEBUG_VM has to be set, which we have only in the debug config.
So only the s390 debug config will have it enabled, you can check
dmesg for "debug_vm_pgtable" to see when / where it was run, and if it
triggered any warnings.

I also checked with the v3 series, and it works fine for s390.
