From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [RFC v2][PATCH 00/35] consolidate pte mapping functions across
 all architectures
Date: Wed, 20 May 2009 15:06:36 -0700
Message-ID: <4A147EEC.4000807@goop.org>
References: <20090520182445.D7B49A7C@kernel>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755701AbZETWHA@vger.kernel.org>
In-Reply-To: <20090520182445.D7B49A7C@kernel>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Hansen <dave@linux.vnet.ibm.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Dave Hansen wrote:
> The steps are as follows, and should be bisectable:
> 1. Break out all the functions into a new asm/ptemap.h and
>    include it in place of the original functions.
> 2. Move linux/mm.h arch-independent pte mapping code to
>    linux/ptemap.h, include asm/ptemap.h there
> 3. Include linux/ptemap.h directly at all use sites
>    (only 39 of these kernel-wide)
> 4. Standardize all the implementations to use
>    pte_offset_kernel() as the basis for pte_offset_map()
>    whenever possible.
> 5. Create asm-generic/ptemap.h and consolidate all the
>    architectures that share the pte_offset_kernel()
>    implementations.
> 6. Consolidate the three HIGHPTE implementations (x86,
>    frv, ppc64) in asm-generic/ptemap.h.  
> 7. Remove the direct asm/ptemap.h includes.
>   

This is a nice cleanup.  Did you consider going an extra step and 
converting all the macros into #defines?

    J
