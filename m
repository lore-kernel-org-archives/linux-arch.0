From: Ram Pai <linuxram@us.ibm.com>
Subject: Re: [RFC v5 02/38] powerpc: Free up four 64K PTE bits in 64K backed
 HPTE pages
Date: Tue, 11 Jul 2017 08:44:15 -0700
Message-ID: <20170711154415.GA5525@ram.oc3035372033.ibm.com>
References: <1499289735-14220-1-git-send-email-linuxram@us.ibm.com>
 <1499289735-14220-3-git-send-email-linuxram@us.ibm.com>
 <20170711155959.79e2d4de@firefly.ozlabs.ibm.com>
Reply-To: Ram Pai <linuxram@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170711155959.79e2d4de@firefly.ozlabs.ibm.com>
Sender: linux-doc-owner@vger.kernel.org
To: Balbir Singh <bsingharora@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, dave.hansen@intel.com, hbabu@us.ibm.com, arnd@arndb.de, akpm@linux-foundation.org, corbet@lwn.net, mingo@redhat.com
List-Id: linux-arch.vger.kernel.org

On Tue, Jul 11, 2017 at 03:59:59PM +1000, Balbir Singh wrote:
> On Wed,  5 Jul 2017 14:21:39 -0700
> Ram Pai <linuxram@us.ibm.com> wrote:
> 
> > Rearrange 64K PTE bits to  free  up  bits 3, 4, 5  and  6
> > in the 64K backed HPTE pages. This along with the earlier
> > patch will  entirely free  up the four bits from 64K PTE.
> > The bit numbers are  big-endian as defined in the  ISA3.0
> > 
> > This patch  does  the  following change to 64K PTE backed
> > by 64K HPTE.
> > 
> > H_PAGE_F_SECOND (S) which  occupied  bit  4  moves to the
> > 	second part of the pte to bit 60.
> > H_PAGE_F_GIX (G,I,X) which  occupied  bit 5, 6 and 7 also
> > 	moves  to  the   second part of the pte to bit 61,
> >        	62, 63, 64 respectively
> > 
> > since bit 7 is now freed up, we move H_PAGE_BUSY (B) from
> > bit  9  to  bit  7.
> > 
> > The second part of the PTE will hold
> > (H_PAGE_F_SECOND|H_PAGE_F_GIX) at bit 60,61,62,63.
> > 
> > Before the patch, the 64K HPTE backed 64k PTE format was
> > as follows
> > 
> >  0 1 2 3 4  5  6  7  8 9 10...........................63
> >  : : : : :  :  :  :  : : :                            :
> >  v v v v v  v  v  v  v v v                            v
> > 
> > ,-,-,-,-,--,--,--,--,-,-,-,-,-,------------------,-,-,-,
> > |x|x|x| |S |G |I |X |x|B|x|x|x|................|.|.|.|.| <- primary pte
> > '_'_'_'_'__'__'__'__'_'_'_'_'_'________________'_'_'_'_'
> > | | | | |  |  |  |  | | | | |..................| | | | | <- secondary pte
> > '_'_'_'_'__'__'__'__'_'_'_'_'__________________'_'_'_'_'
> >
> 
> It's not entirely clear what the secondary pte contains
> today and how many of the bits are free today?

The secondary pte today is not used for anything for 64k-hpte
backed ptes. It gets used the moment the pte gets backed by
4-k hptes. Till then the bits are available. And this patch
makes use of that knowledge. 

Will add some words in the patch description towards this.
Thanks,
RP

> 
> Balbir Singh. 

-- 
Ram Pai

