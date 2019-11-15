From: Daniel Axtens <dja@axtens.net>
Subject: Re: [PATCH v2 1/2] kasan: support instrumented bitops combined with
 generic bitops
Date: Sat, 16 Nov 2019 00:11:03 +1100
Message-ID: <87a78xgu8o.fsf@dja-thinkpad.axtens.net>
References: <20190820024941.12640-1-dja@axtens.net>
 <877e6vutiu.fsf@dja-thinkpad.axtens.net>
 <878sp57z44.fsf@dja-thinkpad.axtens.net>
 <CANpmjNOCxTxTpbB_LwUQS5jzfQ_2zbZVAc4nKf0FRXmrwO-7sA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <CANpmjNOCxTxTpbB_LwUQS5jzfQ_2zbZVAc4nKf0FRXmrwO-7sA@mail.gmail.com>
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

> test_bit() is an atomic bitop. I assume it was meant to be in
> instrumented-atomic.h?

Hmm, interesting.

I was tricked by the generic version doing just a simple read, with only
a volatile attribute to ensure the read occurs more-or-less as written:

/**
 * test_bit - Determine whether a bit is set
 * @nr: bit number to test
 * @addr: Address to start counting from
 */
static inline int test_bit(int nr, const volatile unsigned long *addr)
{
        return 1UL & (addr[BIT_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
}

But the docs do seem to indicate that it's atomic (for whatever that
means for a single read operation?), so you are right, it should live in
instrumented-atomic.h.

Sadly, only x86 and s390 specify an arch_test_bit, which will make moving it
into instumented-atomic.h break powerpc :(

I'll have a crack at something next week, probably with a similar trick
to arch_clear_bit_unlock_is_negative_byte.

Regards,
Daniel


>
> Thanks,
> -- Marco
>
>> >> +
>> >> +#endif /* _ASM_GENERIC_BITOPS_INSTRUMENTED_NON_ATOMIC_H */
>> >> --
>> >> 2.20.1
>>
>> --
>> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
>> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
>> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/878sp57z44.fsf%40dja-thinkpad.axtens.net.
