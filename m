Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Thu, 8 Sep 2005 23:47:42 +0200
From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [RFC] Consistently use the name asm-offsets.h
Message-ID: <20050908214741.GA16421@mars.ravnborg.org>
References: <20050908211539.GA24714@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050908211539.GA24714@mars.ravnborg.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

mips has it own private gen-asm-offset macro,

The important part being:

sed -ne "/^@@@/s///p"; \

compared to the generic one:

sed -ne "/^->/{s:^->\([^ ]*\) [\$$#]*\([^ ]*\) \(.*\):#define \1 \2 /* \3 */:; s:->::; p;}"; \

I wonder why the assembly for mips is so different...
So for now two architectures needs special care: mips and ia64.

	Sam
