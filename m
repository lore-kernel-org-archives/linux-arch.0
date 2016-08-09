From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 2/5] kbuild: allow archs to select build for link dead
 code/data elimination
Date: Mon, 8 Aug 2016 20:16:05 -0700
Message-ID: <20160809031605.GF3078@tassilo.jf.intel.com>
References: <1470399123-8455-1-git-send-email-npiggin@gmail.com>
 <12986071.MeSB5hmlsH@wuerfel>
 <20160807234947.GV20904@bubble.grove.modra.org>
 <1882847.dG563Vieov@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kbuild-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1882847.dG563Vieov@wuerfel>
Sender: linux-kbuild-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Alan Modra <amodra@gmail.com>, linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, Nicolas Pitre <nico@linaro.org>, linux-kbuild@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

> I don't understand what led Andi Kleen to also move .text.hot and
> .text.unlikely together with .text [2], but this may have
> been a related issue.

The goal was just to move .hot and .unlikely all together, so that
they are clustered and use the minimum amount of cache. On x86 doesn't
matter where they are exactly, as long as each is together.
If they are not explicitely listed then the linker interleaves
them with the normal text, which defeats the purpose.

-Andi
