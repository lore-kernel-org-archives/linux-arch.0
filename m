From: Ryan Mallon <rmallon@gmail.com>
Subject: Re: Is spin_is_locked() safe to use with BUG_ON()/WARN_ON()?
Date: Fri, 24 May 2013 11:29:38 +1000
Message-ID: <519EC282.1010800@gmail.com>
References: <CA+55aFww-UYfLA4cN6MSkeXzmAnAruShddAPegCpn+5yd1HGmQ@mail.gmail.com> <6402.1369320636@warthog.procyon.org.uk> <6788.1369321955@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6788.1369321955@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, milosz@adfin.com, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On 24/05/13 01:12, David Howells wrote:
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
>> We do *not* want to add some crazy "spin_is_nt_locked". We just want
>> to get rid of these idiotic debug tests.
> 
> Generally, I think you are right, though there are also some checks in
> deallocation routines that check that a spinlock is not currently held before
> releasing the memory holding it - should those be allowed to stay?  I'd be
> tempted to wrap the whole check in something, perhaps an "spin_lock_uninit()"
> and move the check to a header file.  Would this be useful for lockdep or
> anything like that?

lockdep has lockdep_assert_held(), which might be what you want. Though
it looks like it possibly also has the false positive issues on SMP?

~Ryan
