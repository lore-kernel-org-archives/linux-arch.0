From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 1/5] kbuild: allow architectures to use thin archives
 instead of ld -r
Date: Sun, 7 Aug 2016 11:49:46 +1000
Message-ID: <20160807114946.41b682f3@canb.auug.org.au>
References: <1470399123-8455-1-git-send-email-npiggin@gmail.com>
	<1470399123-8455-2-git-send-email-npiggin@gmail.com>
	<20160806201045.GA25821@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <20160806201045.GA25821@ravnborg.org>
Sender: linux-kbuild-owner@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@linaro.org>, Segher Boessenkool <segher@kernel.crashing.org>, Alan Modra <amodra@gmail.com>
List-Id: linux-arch.vger.kernel.org

Hi Sam,

On Sat, 6 Aug 2016 22:10:45 +0200 Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Did you by any chance evalue the use of INPUT in linker files.
> Stephen back then (again based on proposal from Alan Modra),
> also made an implementation using INPUT.

The problem with that idea was that (at least for some versions of
binutils in use at the time) we hit a static limit to the number of
object files and ld just stopped at that point. :-(

> See below for an updated simple patch on top of mainline.

So, I guess it was fixed, but do we know in what version?

-- 
Cheers,
Stephen Rothwell
