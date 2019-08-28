From: Borislav Petkov <bp@alien8.de>
Subject: Re: Asm & local labels for functions [was: [PATCH v8 05/28] x86/asm:
 annotate local pseudo-functions]
Date: Wed, 28 Aug 2019 14:24:17 +0200
Message-ID: <20190828122417.GH4920@zn.tnic>
References: <20190808103854.6192-1-jslaby@suse.cz>
 <20190808103854.6192-6-jslaby@suse.cz>
 <20190815160719.GI15313@zn.tnic>
 <c5e0f683-796c-f552-0c3b-8a1105446200@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c5e0f683-796c-f552-0c3b-8a1105446200@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Wed, Aug 28, 2019 at 01:47:23PM +0200, Jiri Slaby wrote:
> Let's start with this one: do you really want me to get rid of (local)
> symbols like this? It would make backtraces completely misleading as the
> unwinder would put a name of the previous function (or some garbage,
> depending on unwinder) into the backtrace...

Yes, while looking at your patches, I was thinking about what
would be a good rule to use with which to make symbols local. I
guess those which are small and not really important for stack
traces like "bad_gs" in entry_64., for example. Or "relocated" in
arch/x86/boot/compressed/head_64.S, as another example. That last one
you probably are never going to see in stack traces due to it being too
early anyway.

Or, if we think that those symbols are important for stack traces, then
they should be called something more prominent, with a naming prefix or
so, so that they can be assigned to the respective source easier.

Am I making some sense?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
