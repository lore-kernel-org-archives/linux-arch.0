From: Daniel Axtens <dja@axtens.net>
Subject: Re: [PATCH v2 1/2] kasan: support instrumented bitops combined with
 generic bitops
Date: Wed, 20 Nov 2019 18:42:50 +1100
Message-ID: <87y2wbf0xx.fsf@dja-thinkpad.axtens.net>
References: <20190820024941.12640-1-dja@axtens.net>
 <877e6vutiu.fsf@dja-thinkpad.axtens.net>
 <878sp57z44.fsf@dja-thinkpad.axtens.net>
 <CANpmjNOCxTxTpbB_LwUQS5jzfQ_2zbZVAc4nKf0FRXmrwO-7sA@mail.gmail.com>
 <87a78xgu8o.fsf@dja-thinkpad.axtens.net>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <87a78xgu8o.fsf@dja-thinkpad.axtens.net>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Marco Elver <elver@google.com>
Cc: linux-s390@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>, kasan-dev <kasan-dev@googlegroups.com>, linux-arch <linux-arch@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org
List-Id: linux-arch.vger.kernel.org

> But the docs do seem to indicate that it's atomic (for whatever that
> means for a single read operation?), so you are right, it should live in
> instrumented-atomic.h.

Actually, on further inspection, test_bit has lived in
bitops/non-atomic.h since it was added in 4117b02132d1 ("[PATCH] bitops:
generic __{,test_and_}{set,clear,change}_bit() and test_bit()")

So to match that, the wrapper should live in instrumented-non-atomic.h
too.

If test_bit should move, that would need to be a different patch. But I
don't really know if it makes too much sense to stress about a read
operation, as opposed to a read/modify/write...

Regards,
Daniel
