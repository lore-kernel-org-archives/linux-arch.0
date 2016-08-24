From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/3 v3] kbuild changes, thin archives, --gc-sections
Date: Wed, 24 Aug 2016 15:06:39 +0200
Message-ID: <1686648.CKXrTpUETq@wuerfel>
References: <1472041761-14414-1-git-send-email-npiggin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <1472041761-14414-1-git-send-email-npiggin@gmail.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Michal Marek <mmarek@suse.com>, linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Nicolas Pitre <nico@linaro.org>, Segher Boessenkool <segher@kernel.crashing.org>, Alan Modra <amodra@gmail.com>
List-Id: linux-arch.vger.kernel.org

On Wednesday, August 24, 2016 10:29:18 PM CEST Nicholas Piggin wrote:
> Hi Michal,
> 
> I ended up deciding to do a v3, because I had several changes
> accumulated, as described in patches.
> 
> I've also left off the powerpc arch patches -- they can be found
> in previous posts, for reference.
> 
> I've again tested ARM and it seems to be building okay and without
> performance regression with my configurations. I think it's going
> to be a matter of some toolchain options for them to go through.
> arm64, x86, powerpc, and arm for me all built fine with thin archives
> and --gc-sections enabled, so I can't see there being a fundamental
> issue that can't be solved. Worst case, the incremental link option
> can remain for a time.
> 

I clearly want to use this on ARM, and I am still investigating
the performance regression that I see on my build box, but that
is no reason to delay your patches.

Everything looks good to me,

Acked-by: Arnd Bergmann <arnd@arndb.de>
