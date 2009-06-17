From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Representing Embedded Architectures at the Kernel Summit
Date: Wed, 17 Jun 2009 09:31:48 -0500
Message-ID: <BE4622E9-611A-4D56-BB54-3C7786939CF2@kernel.crashing.org>
References: <1243956140.4229.25.camel@mulgrave.int.hansenpartnership.com>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-embedded-owner@vger.kernel.org>
In-Reply-To: <1243956140.4229.25.camel@mulgrave.int.hansenpartnership.com>
Sender: linux-embedded-owner@vger.kernel.org
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: ksummit-2009-discuss@lists.linux-foundation.org, linux-arch@vger.kernel.org, linux-embedded@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

One topic that was partially touched on was dealing with various  
memories on embedded systems.  We have several sram based allocators  
in the kernel for various different arch's:

- Blackfin sram allocator arch/blackfin/mm/sram-alloc.c
- Lite5200(b) sram allocator arch/powerpc/sysdev/bestcomm/sram.c
- AVR32 sram allocator arch/avr32/mach-at32ap/at32ap700x.c and arch/ 
avr32/mach-at32ap/include/mach/sram.h
- Potential davinci sram allocator

There maybe others.

- k
