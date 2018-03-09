From: Ram Pai <linuxram@us.ibm.com>
Subject: Re: [PATCH] x86, powerpc : pkey-mprotect must allow pkey-0
Date: Fri, 9 Mar 2018 11:54:35 -0800
Message-ID: <20180309195435.GQ1060@ram.oc3035372033.ibm.com>
References: <1520583161-11741-1-git-send-email-linuxram@us.ibm.com>
 <CAKTCnz=QrNoG0wdTZRJqmYfFOZmq2czZ4x8v1e=ouNx2Y8D6wg@mail.gmail.com>
Reply-To: Ram Pai <linuxram@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKTCnz=QrNoG0wdTZRJqmYfFOZmq2czZ4x8v1e=ouNx2Y8D6wg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Balbir Singh <bsingharora@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Ingo Molnar <mingo@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" <linuxppc-dev@lists.ozlabs.org>, linux-mm <linux-mm@kvack.org>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dave Hansen <dave.hansen@intel.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Anshuman Khandual <khandual@linux.vnet.ibm.com>, Aneesh Kumar KV <aneesh.kumar@linux.vnet.ibm.com>, Haren Myneni/Beaverton/IBM <hbabu@us.ibm.com>, Michal Hocko <mhocko@kernel.org>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
List-Id: linux-arch.vger.kernel.org

On Fri, Mar 09, 2018 at 07:37:04PM +1100, Balbir Singh wrote:
> On Fri, Mar 9, 2018 at 7:12 PM, Ram Pai <linuxram@us.ibm.com> wrote:
> > Once an address range is associated with an allocated pkey, it cannot be
> > reverted back to key-0. There is no valid reason for the above behavior.  On
> > the contrary applications need the ability to do so.
> >
> > The patch relaxes the restriction.
> 
> I looked at the code and my observation was going to be that we need
> to change mm_pkey_is_allocated. I still fail to understand what
> happens if pkey 0 is reserved? What is the default key is it the first
> available key? Assuming 0 is the default key may work and seems to
> work, but I am sure its mostly by accident. It would be nice, if we
> could have  a notion of the default key. I don't like the special
> meaning given to key 0 here. Remember on powerpc if 0 is reserved and
> UAMOR/AMOR does not allow modification because it's reserved, setting
> 0 will still fail

The linux pkey API, assumes pkey-0 is the default key. If no key is
explicitly associated with a page, the default key gets associated.
When a default key gets associated with a page, the permissions on the
page are not dictated by the permissions of the default key, but by the
permission of other bits in the pte; i.e _PAGE_RWX.

On powerpc, and AFAICT on x86, neither the hardware nor the hypervisor
reserves key-0. Hence the OS is free to use the key value, the
way it chooses. On Linux we choose to associate key-0 the special status
called default-key.

However I see your point. If some cpu architecture takes away key-0 from
Linux, than implementing the special status for key-0 on that
architecture can become challenging, though not impossible. That
architecture implementation can internally map key-0 value to some other
available key, and associate that key to the page. And offcourse make
sure that the hardware/MMU uses the pte's RWX bits to enforce
permissions, for that key.


-- 
Ram Pai
