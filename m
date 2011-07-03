From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC v1] implement SL*B and stack usercopy runtime checks
Date: Sun, 3 Jul 2011 11:27:47 -0700
Message-ID: <CA+55aFzXEoTyK0Sm-y=6xGmLMWzQiSQ7ELJ2-WL_PrP3r44MSg@mail.gmail.com>
References: <20110703111028.GA2862@albatros>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20110703111028.GA2862@albatros>
Sender: owner-linux-mm@kvack.org
To: Vasiliy Kulikov <segoon@openwall.com>
Cc: kernel-hardening@lists.openwall.com, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, Christoph Lameter <cl@linux-foundation.org>, Pekka Enberg <penberg@kernel.org>, Matt Mackall <mpm@selenic.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
List-Id: linux-arch.vger.kernel.org

That patch is entirely insane. No way in hell will that ever get merged.

copy_to/from_user() is some of the most performance-critical code, and
runs a *lot*, often for fairly small structures (ie 'fstat()' etc).

Adding random ad-hoc tests to it is entirely inappropriate. Doing so
unconditionally is insane.

So NAK, NAK, NAK.

If you seriously clean it up (that at a minimum includes things like
making it configurable using some pretty helper function that just
compiles away for all the normal cases, and not writing out

   if (!slab_access_ok(to, n) || !stack_access_ok(to, n))

multiple times, for chrissake) it _might_ be acceptable.

But in its current form it's just total crap. It's exactly the kind of
"crazy security people who don't care about anything BUT security"
crap that I refuse to see.

Some balance and sanity.

                      Linus

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Fight unfair telecom internet charges in Canada: sign http://stopthemeter.ca/
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
