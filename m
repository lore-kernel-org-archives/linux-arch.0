From: Ram Pai <linuxram@us.ibm.com>
Subject: Re: [RFC v5 00/38] powerpc: Memory Protection Keys
Date: Mon, 10 Jul 2017 10:15:36 -0700
Message-ID: <20170710171536.GA5716@ram.oc3035372033.ibm.com>
References: <1499289735-14220-1-git-send-email-linuxram@us.ibm.com>
 <d9030b2c-493b-94c4-8c97-8aaec3be34ba@linux.vnet.ibm.com>
 <20170710060544.GF5713@ram.oc3035372033.ibm.com>
Reply-To: Ram Pai <linuxram@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <20170710060544.GF5713@ram.oc3035372033.ibm.com>
Sender: owner-linux-mm@kvack.org
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, dave.hansen@intel.com, hbabu@us.ibm.com, arnd@arndb.de, akpm@linux-foundation.org, corbet@lwn.net, mingo@redhat.com
List-Id: linux-arch.vger.kernel.org

On Sun, Jul 09, 2017 at 11:05:44PM -0700, Ram Pai wrote:
> On Mon, Jul 10, 2017 at 11:13:23AM +0530, Anshuman Khandual wrote:
> > On 07/06/2017 02:51 AM, Ram Pai wrote:
.....
> 
> > do you have data points to show the difference in
> > performance between this version and the last one where
> > we skipped the bits from PTE and directly programmed the
> > HPTE entries looking into VMA bits.
> 
> No. I dont. I am hoping you can help me out with this.
Anshuman,
	The last version where we skipped the PTE bits is guaranteed
	to be bad/horrible. For one it has a bug, since it accesses
	the vma without a lock. And even if we did take a lock, it
	will slow down the page-hash path un-acceptably. So there is
	no point measuring the performance of that design.

	I think the number we want to measure is -- the performance 
	with the current design and comparing that to the performance
	without memkey feature. We want to find if there is
	any degradation by adding this feature.

RP

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
