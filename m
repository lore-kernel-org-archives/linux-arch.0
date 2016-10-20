From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/2] kbuild: modversions for exported asm symbols
Date: Thu, 20 Oct 2016 10:03:14 +0200
Message-ID: <16513464.3RM484EDf1@wuerfel>
References: <20161015124352.10795-1-npiggin@gmail.com> <7315031.MmlhY1rulM@wuerfel> <20161020145827.453025a6@roar.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <20161020145827.453025a6@roar.ozlabs.ibm.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Michal Marek <mmarek@suse.com>, linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
List-Id: linux-arch.vger.kernel.org

On Thursday, October 20, 2016 2:58:27 PM CEST Nicholas Piggin wrote:
> 
> Yeah, I had the same idea as you and Michal too. It's conceptually nicer,
> but in practice it turned into a mess. If some architectures wanted to start
> protecting their .h files and including them into .S for the prototypes, we
> could start parsing those too. Should we do the quick and dirty way for 4.9?

Let's stay with your approach for now.

	Arnd
