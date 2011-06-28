From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] modules: add default loader hook implementations
Date: Tue, 28 Jun 2011 12:45:19 +0200
Message-ID: <201106281245.19457.arnd@arndb.de>
References: <1308987512-6583-1-git-send-email-jonas@southpole.se> <201106271305.44746.arnd@arndb.de> <87mxh2lpey.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87mxh2lpey.fsf@rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Jonas Bonn <jonas@southpole.se>, Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, monstr@monstr.eu, cmetcalf@tilera.com, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

On Tuesday 28 June 2011, Rusty Russell wrote:
> To avoid more bikeshedding, smallest patch wins.  That's __weak, right?

Sounds fine to me. Jonas, can you send that patch?

	Arnd
