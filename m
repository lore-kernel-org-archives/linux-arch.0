From: Michal Marek <mmarek@suse.com>
Subject: Re: [GIT PULL] kbuild changes for v4.9-rc1
Date: Wed, 19 Oct 2016 16:38:14 +0200
Message-ID: <70c4e6bf-1667-326b-8a4d-b0960b55a5e7@suse.com>
References: <20161017100130.GA16013@angband.pl> <871szfb1x1.fsf@gmail.com>
 <20161018001626.GA5976@angband.pl>
 <20161018123418.6121175b@roar.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161018123418.6121175b@roar.ozlabs.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicholas Piggin <npiggin@gmail.com>, Adam Borowski <kilobyte@angband.pl>
Cc: Mathieu OTHACEHE <m.othacehe@gmail.com>, Omar Sandoval <osandov@osandov.com>, Linus Torvalds <torvalds@linux-foundation.org>, adobriyan@gmail.com, sfr@canb.auug.org.au, viro@zeniv.linux.org.uk, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Dne 18.10.2016 v 03:34 Nicholas Piggin napsal(a):
> We should probably just bring all these arch patches through the
> kbuild tree.
> 
> I'm sorry for the breakage: I didn't realize it broke the build with
> some configs, otherwise I would have given Michal a heads up before
> his pull request, and worked to get this stuff in first.

It breaks with some binutils versions only (and only with
CONFIG_MODVERSIONS=y, of course).

Michal
