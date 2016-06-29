From: =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>
Subject: Re: [PATCH v4 00/29] virtually mapped stacks and thread_info cleanup
Date: Wed, 29 Jun 2016 20:24:16 +0300
Message-ID: <57740440.9090302@nextfour.com>
References: <cover.1466974736.git.luto@kernel.org>
 <5773736D.40500@nextfour.com>
Reply-To: kernel-hardening@lists.openwall.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <kernel-hardening-return-3785-glkh-kernel-hardening=m.gmane.org@lists.openwall.com>
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
In-Reply-To: <5773736D.40500@nextfour.com>
To: Andy Lutomirski <luto@kernel.org>, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Borislav Petkov <bp@alien8.de>, Nadav Amit <nadav.amit@gmail.com>, Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, Linus Torvalds <torvalds@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Jann Horn <jann@thejh.net>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-Id: linux-arch.vger.kernel.org



On 29.06.2016 10:06, Mika Penttilä wrote:
> On 06/27/2016 12:55 AM, Andy Lutomirski wrote:
>> Hi all-
>>
>> Known issues:
>>  - tcp md5, virtio_net, and virtio_console will have issues.  Eric Dumazet
>>    has a patch for tcp md5, and Michael Tsirkin says he'll fix virtio_net
>>    and virtio_console.
>>
>  How about PTRACE_SETREGS, it's using the child stack's vmapped address to put regs?
>
> --Mika
>
PTRACE_SETREGS is ok of course.

--Mika
