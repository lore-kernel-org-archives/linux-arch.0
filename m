From: Nadav Amit <namit@vmware.com>
Subject: Re: [RFC PATCH 6/6] x86/alternatives: remove text_poke() return value
Date: Wed, 29 Aug 2018 17:15:28 +0000
Message-ID: <F9672E89-C01C-443C-A1FB-6EA2B66CBB4D@vmware.com>
References: <20180829081147.184610-1-namit@vmware.com>
 <20180829081147.184610-7-namit@vmware.com>
 <20180829185222.e85026ff22638002a1df70e0@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180829185222.e85026ff22638002a1df70e0@kernel.org>
Content-Language: en-US
Content-ID: <62C9C6614C839649A17A51265DEFD93E@namprd05.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>, Kees Cook <keescook@chromium.org>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-arch.vger.kernel.org

at 2:52 AM, Masami Hiramatsu <mhiramat@kernel.org> wrote:

>> --- a/arch/x86/kernel/alternative.c
>> +++ b/arch/x86/kernel/alternative.c
>> @@ -795,7 +795,7 @@ static void text_poke_safe(void *addr, const void *o=
pcode, size_t len,
>>  *
>>  * Note: Must be called under text_mutex.
>>  */
>> -void *text_poke(void *addr, const void *opcode, size_t len)
>> +void text_poke(void *addr, const void *opcode, size_t len)
>> {
>> 	bool cross_page_boundary =3D offset_in_page(addr) + len > PAGE_SIZE;
>> 	struct page *pages[2] =3D {0};
>=20
> Could you also remove "return addr;" in this patch ?

Oops. Thanks!
