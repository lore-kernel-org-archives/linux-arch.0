From: Ram Pai <linuxram@us.ibm.com>
Subject: Re: [PATCH v9 00/51] powerpc, mm: Memory Protection Keys
Date: Sun, 12 Nov 2017 12:45:10 -0800
Message-ID: <20171112204510.GE5546@ram.oc3035372033.ibm.com>
References: <1509958663-18737-1-git-send-email-linuxram@us.ibm.com>
 <45ca9196-1d7d-d530-45df-4ee41773cace@c-s.fr>
Reply-To: Ram Pai <linuxram@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <45ca9196-1d7d-d530-45df-4ee41773cace@c-s.fr>
Sender: linux-doc-owner@vger.kernel.org
To: Christophe LEROY <christophe.leroy@c-s.fr>
Cc: mpe@ellerman.id.au, mingo@redhat.com, akpm@linux-foundation.org, corbet@lwn.net, arnd@arndb.de, linux-arch@vger.kernel.org, ebiederm@xmission.com, linux-doc@vger.kernel.org, x86@kernel.org, dave.hansen@intel.com, linux-kernel@vger.kernel.org, mhocko@kernel.org, linux-mm@kvack.org, paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com, linux-kselftest@vger.kernel.org, bauerman@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, khandual@linux.vnet.ibm.com
List-Id: linux-arch.vger.kernel.org

On Fri, Nov 10, 2017 at 07:10:31PM +0100, Christophe LEROY wrote:
> Hi
> 
> Le 06/11/2017 à 09:56, Ram Pai a écrit :
> >Memory protection keys enable applications to protect its
> >address space from inadvertent access from or corruption
> >by itself.
> >
> >These patches along with the pte-bit freeing patch series
> >enables the protection key feature on powerpc; 4k and 64k
> >hashpage kernels. It also changes the generic and x86
> >code to expose memkey features through sysfs. Finally
> >testcases and Documentation is updated.
> >
> >All patches can be found at --
> >https://github.com/rampai/memorykeys.git memkey.v9
> 
> As far as I can see you are focussing the implementation on 64 bits
> powerpc. This could also be implemented on 32 bits powerpc, for
> instance the 8xx has MMU Access Protection Registers which can be
> used to define 16 domains and could I think be used for implementing
> protection keys.

I was assuming non-existence of any 32bit powerpc
systems supporting memory keys. Sounds like it was a wrong assumption.

However, I think, the framework as it stands today should work. All
the functionality is captured in pkeys.c and pkeys.h which are generic
ppc files.  Its just a matter of providing the 32-bit implementation
for whichever sub-arch that support it.  Can you point me to problem
areas? I will fix them.

Thanks for you interest. Togather we should be able to make it
happen.


> Of course the challenge after that would be to find 4 spare PTE
> bits, I'm sure we can find them on the 8xx, at least when using 16k
> pages we have 2 bits already available, then by merging PAGE_SHARED
> and PAGE_USER and by reducing PAGE_RO to only one bit we can get the
> 4 spare bits.

yes. This needs to happen parallely.
RP

> 
> Therefore I think it would be great if you could implement a
> framework common to both PPC32 and PPC64.

