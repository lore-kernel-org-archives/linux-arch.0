From: Balbir Singh <bsingharora@gmail.com>
Subject: Re: [PATCH v4] mm, pkey: treat pkey-0 special
Date: Fri, 16 Mar 2018 22:02:22 +1100
Message-ID: <CAKTCnzmSCT+VecdSRpyY2Rb_AW2ngCi3UTZfLE3VOLNSQn6vsA@mail.gmail.com>
References: <1521196416-18157-1-git-send-email-linuxram@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1521196416-18157-1-git-send-email-linuxram@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ram Pai <linuxram@us.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Ingo Molnar <mingo@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" <linuxppc-dev@lists.ozlabs.org>, linux-mm <linux-mm@kvack.org>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dave Hansen <dave.hansen@intel.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Anshuman Khandual <khandual@linux.vnet.ibm.com>, Aneesh Kumar KV <aneesh.kumar@linux.vnet.ibm.com>, Haren Myneni/Beaverton/IBM <hbabu@us.ibm.com>, Michal Hocko <mhocko@kernel.org>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
List-Id: linux-arch.vger.kernel.org

On Fri, Mar 16, 2018 at 9:33 PM, Ram Pai <linuxram@us.ibm.com> wrote:
> Applications need the ability to associate an address-range with some
> key and latter revert to its initial default key. Pkey-0 comes close to
> providing this function but falls short, because the current
> implementation disallows applications to explicitly associate pkey-0 to
> the address range.
>
> Clarify the semantics of pkey-0 and provide the corresponding
> implementation.
>
> Pkey-0 is special with the following semantics.
> (a) it is implicitly allocated and can never be freed. It always exists.
> (b) it is the default key assigned to any address-range.
> (c) it can be explicitly associated with any address-range.
>
> Tested on powerpc only. Could not test on x86.


Ram,

I was wondering if we should check the AMOR values on the ppc side to make sure
that pkey0 is indeed available for use as default. I am still of the
opinion that we
should consider non-0 default pkey in the long run. I'm OK with the patches for
now, but really 0 is not special except for it being the default bit
values present
in the PTE.

The patches themselves look OK to me

Balbir Singh.
