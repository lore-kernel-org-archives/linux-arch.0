From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH 2/5] kbuild: allow archs to select build for link dead code/data elimination
Date: Sun, 07 Aug 2016 13:35:04 +0200
Message-ID: <87oa5495hz.fsf@linux-m68k.org>
References: <1470399123-8455-1-git-send-email-npiggin@gmail.com>
	<1470399123-8455-3-git-send-email-npiggin@gmail.com>
	<20160807095739.GU20904@bubble.grove.modra.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <20160807095739.GU20904@bubble.grove.modra.org> (Alan Modra's
	message of "Sun, 7 Aug 2016 19:27:39 +0930")
Sender: linux-kbuild-owner@vger.kernel.org
To: Alan Modra <amodra@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@linaro.org>, Segher Boessenkool <segher@kernel.crashing.org>
List-Id: linux-arch.vger.kernel.org

On So, Aug 07 2016, Alan Modra <amodra@gmail.com> wrote:

> At the risk of being told you (kernel people) have already considerd
> this I thought I should mention that the above isn't ideal.  (Nor is
> gcc's choice of .text.hot for hot sections, which clashes with
> --function-sections for a function called "hot" but that's another
> story.)

Or --function-sections should use a unique prefix, like
.text.functions.*

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
