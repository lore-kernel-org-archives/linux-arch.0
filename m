From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 2/4] introduce post-init read-only memory
Date: Mon, 30 Nov 2015 14:24:59 -0800
Message-ID: <565CCCBB.1070500@zytor.com>
References: <1448494286-16029-1-git-send-email-keescook@chromium.org>
 <1448494286-16029-3-git-send-email-keescook@chromium.org>
 <56564F0F.3158.108D0B78@pageexec.freemail.hu>
Reply-To: kernel-hardening@lists.openwall.com
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <kernel-hardening-return-2026-glkh-kernel-hardening=m.gmane.org@lists.openwall.com>
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
In-Reply-To: <56564F0F.3158.108D0B78@pageexec.freemail.hu>
To: pageexec@freemail.hu, linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Michael Ellerman <mpe@ellerman.id.au>, Mathias Krause <minipli@googlemail.com>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, Emese Revfy <re.emese@gmail.com>, kernel-hardening@lists.openwall.com, linux-arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On 11/25/15 16:15, PaX Team wrote:
> On 25 Nov 2015 at 15:31, Kees Cook wrote:
> 
>> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
>> index c4bd0e2c173c..772c784ba763 100644
>> --- a/include/asm-generic/vmlinux.lds.h
>> +++ b/include/asm-generic/vmlinux.lds.h
>> @@ -256,6 +256,7 @@
>>   .rodata           : AT(ADDR(.rodata) - LOAD_OFFSET) {		\
>>    VMLINUX_SYMBOL(__start_rodata) = .;			\
>>    *(.rodata) *(.rodata.*)					\
>> +		*(.data..ro_after_init)	/* Read only after init */	\
>    ^^^^^^^^^^^
> looks like it's tabs vs. spaces...
> 

One more thing... double dots I think has special meanings to gcc, so it
might be better to avoid.

	-hpa
