From: Vincent Chen <deanbo422@gmail.com>
Subject: Fwd: FW: [PATCH 18/31] nds32: Library functions
Date: Tue, 14 Nov 2017 12:47:04 +0800
Message-ID: <CAJsyPhx+tRHWrvJg4Dr4QEEHtOy8jXAU2aP2=hHhmTmG3FsO9A@mail.gmail.com>
References: <cover.1510118606.git.green.hu@gmail.com> <ea57a25c0aceab45d36951fed44cfbecfe1540b8.1510118606.git.green.hu@gmail.com>
 <20171109004020.GX21978@ZenIV.linux.org.uk> <E26F4CF8B7DDDB4383A6C2D78D5C3CD56B497559@ATCPCS16.andestech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <E26F4CF8B7DDDB4383A6C2D78D5C3CD56B497559@ATCPCS16.andestech.com>
Sender: linux-kernel-owner@vger.kernel.org
To: viro@ftp.linux.org.uk
Cc: greentime@andestech.com, Green Hu <green.hu@gmail.com>, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, vincentc@andestech.com
List-Id: linux-arch.vger.kernel.org

>>On Wed, Nov 08, 2017 at 01:55:06PM +0800, Greentime Hu wrote:
>
>> +#define __range_ok(addr, size) (size <= get_fs() && addr <= (get_fs()
>> +-size))
>> +
>> +#define access_ok(type, addr, size)                 \
>> +     __range_ok((unsigned long)addr, (unsigned long)size)
>
>> +#define __get_user_x(__r2,__p,__e,__s,__i...)                                \
>> +        __asm__ __volatile__ (                                       \
>> +             __asmeq("%0", "$r0") __asmeq("%1", "$r2")               \
>> +             "bal    __get_user_" #__s                               \
>
>... which does not check access_ok() or do any visible equivalents; OK...
>
>> +#define get_user(x,p)                                                        \
>> +     ({                                                              \
>> +             const register typeof(*(p)) __user *__p asm("$r0") = (p);\
>> +             register unsigned long __r2 asm("$r2");                 \
>> +             register int __e asm("$r0");                            \
>> +             switch (sizeof(*(__p))) {                               \
>> +             case 1:                                                 \
>> +                     __get_user_x(__r2, __p, __e, 1, "$lp");         \
>
>... and neither does this, which is almost certainly *not* OK.
>
>> +#define put_user(x,p)                                                        \
>
>Same here, AFAICS.

Thanks.
I will add access_ok() in get_user/put_user

>> +extern unsigned long __arch_copy_from_user(void *to, const void __user * from,
>> +                                        unsigned long n);
>
>> +static inline unsigned long raw_copy_from_user(void *to,
>> +                                            const void __user * from,
>> +                                            unsigned long n)
>> +{
>> +     return __arch_copy_from_user(to, from, n); }
>
>Er...  Why not call your __arch_... raw_... and be done with that?

Thanks.
I will modify it in next patch version

>> +#define INLINE_COPY_FROM_USER
>> +#define INLINE_COPY_TO_USER
>
>Are those actually worth bothering?  IOW, have you compared behaviour with and without them?

We compared the assembly code of copy_from/to_user's caller function,
and we think the performance is better by making copy_from/to_user as
inline


>> +ENTRY(__arch_copy_to_user)
>> +     push    $r0
>> +     push    $r2
>> +     beqz    $r2, ctu_exit
>> +     srli    $p0, $r2, #2            ! $p0 = number of word to clear
>> +     andi    $r2, $r2, #3            ! Bytes less than a word to copy
>> +     beqz    $p0, byte_ctu           ! Only less than a word to copy
>> +word_ctu:
>> +     lmw.bim $p1, [$r1], $p1         ! Load the next word
>> +USER(        smw.bim,$p1, [$r0], $p1)        ! Store the next word
>
>Umm...  It's that happy with unaligned loads and stores?  Your memcpy seems to be trying to avoid those...

Thanks.
This should be aligned loads and stores, too.
I will modify it in next version patch.

>> +9001:
>> +     pop     $p1                     ! Original $r2, n
>> +     pop     $p0                     ! Original $r0, void *to
>> +     sub     $r1, $r0, $p0           ! Bytes copied
>> +     sub     $r2, $p1, $r1           ! Bytes left to copy
>> +     push    $lp
>> +     move    $r0, $p0
>> +     bal     memzero                 ! Clean up the memory
>
>Just what memory are you zeroing here?  The one you had been unable to store into in the first place?
>
>> +ENTRY(__arch_copy_from_user)
>
>> +9001:
>> +     pop     $p1                     ! Original $r2, n
>> +     pop     $p0                     ! Original $r0, void *to
>> +     sub     $r1, $r1, $p0           ! Bytes copied
>> +     sub     $r2, $p1, $r1           ! Bytes left to copy
>> +     push    $lp
>> +     bal     memzero                 ! Clean up the memory
>
>Ditto, only this one is even worse - instead of just oopsing on you, it will quietly destroy data past the area you've copied into.  raw_copy_..._user() MUST NOT ZERO ANYTHING.  Ever.


Thanks
So, I should keep the area that we've copied into instead of zeroing
the area even if unpredicted exception is happened. Right?


Best regards
Vincent
