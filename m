Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Fri, 9 Sep 2005 12:17:03 +0100
From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [RFC] Consistently use the name asm-offsets.h
Message-ID: <20050909111703.GD3747@linux-mips.org>
References: <20050908211539.GA24714@mars.ravnborg.org> <20050908214741.GA16421@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050908214741.GA16421@mars.ravnborg.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, Sep 08, 2005 at 11:47:42PM +0200, Sam Ravnborg wrote:

> mips has it own private gen-asm-offset macro,
> 
> The important part being:
> 
> sed -ne "/^@@@/s///p"; \
> 
> compared to the generic one:
> 
> sed -ne "/^->/{s:^->\([^ ]*\) [\$$#]*\([^ ]*\) \(.*\):#define \1 \2 /* \3 */:; s:->::; p;}"; \
> 
> I wonder why the assembly for mips is so different...
> So for now two architectures needs special care: mips and ia64.

MIPS uses it's own rules only for readability of the generated file.

  Ralf
