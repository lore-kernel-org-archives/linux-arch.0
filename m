From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3 2/8] lib: add "on" and "off" to strtobool
Date: Fri, 11 Dec 2015 23:20:28 +0200
Message-ID: <CAHp75Vf-Y+8PUMnU9k9pAjXbdWwiZoTnOhcohKeKS+aTt_fC3Q@mail.gmail.com>
References: <1449697404-21076-1-git-send-email-keescook@chromium.org>
	<1449697404-21076-3-git-send-email-keescook@chromium.org>
	<CAHp75VeJovidU+dWL6Su9YkpP+zmMUw=yrtLh2PmGRZRun-D8g@mail.gmail.com>
	<CAGXu5jK8dTL5PVnF7G+xf=RvWX82G9NFy+jEqkNmV7V0zc-LxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk0-f173.google.com ([209.85.220.173]:34396 "EHLO
	mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751437AbbLKVU3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 11 Dec 2015 16:20:29 -0500
In-Reply-To: <CAGXu5jK8dTL5PVnF7G+xf=RvWX82G9NFy+jEqkNmV7V0zc-LxQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Daniel Borkmann <daniel@iogearbox.net>, Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@amacapital.net>, "H. Peter Anvin" <hpa@zytor.com>, Michael Ellerman <mpe@ellerman.id.au>, Mathias Krause <minipli@googlemail.com>, Thomas Gleixner <tglx@linutronix.de>, "x86@kernel.org" <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>, PaX Team <pageexec@freemail.hu>, Emese Revfy <re.emese@gmail.com>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, linux-arch <linux-arch@vger.kernel.org>

On Fri, Dec 11, 2015 at 8:50 PM, Kees Cook <keescook@chromium.org> wrot=
e:
> On Fri, Dec 11, 2015 at 9:00 AM, Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>> On Wed, Dec 9, 2015 at 11:43 PM, Kees Cook <keescook@chromium.org> w=
rote:
>>> Several places in the kernel expect to use "on" and "off" for their
>>> boolean signifiers, so add them to strtobool.

>>> +       if (!s)
>>> +               return -EINVAL;
>>> +
>>
>> This change I think is better to do separately. Do we have even need=
 for it?
>
> I'm happy to separate it, sure. I added it here because several of th=
e
> __setup and param callers do a check for !NULL input, and it made thi=
s
> cleaner. Also it seems sensible to do this check anyway.

OK.

>>> +               default:
>>> +                       return -EINVAL;
>>> +               }
>>> +               break;
>>>         default:
>>>                 return -EINVAL;
>>
>> Maybe in both cases
>> default:
>>  break;
>> }
>> =E2=80=A6
>> }
>> return -EINVAL;
>
> I went back and forth on this. To switch to the fall-back being EINVA=
L
> meant I had to change all the other "breaks" into "return 0", and it
> just looked ugly to me. If that is preferred, though, I'm happy to do
> it.

I have no strong feelings about that, I prefer whatever looks neater.

--=20
With Best Regards,
Andy Shevchenko
