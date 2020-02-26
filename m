From: =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [RFC PATCH v14 00/10] Landlock LSM
Date: Wed, 26 Feb 2020 16:34:59 +0100
Message-ID: <5ec24e38-1a6f-590a-3b30-50caae177e9b@digikod.net>
References: <20200224160215.4136-1-mic@digikod.net>
 <6df3e6b1-ffd1-dacf-2f2d-7df8e5aca668@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <kernel-hardening-return-17960-glkh-kernel-hardening=m.gmane-mx.org@lists.openwall.com>
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
In-Reply-To: <6df3e6b1-ffd1-dacf-2f2d-7df8e5aca668@gmail.com>
Content-Language: en-US
To: J Freyensee <why2jjj.linux@gmail.com>, linux-kernel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@amacapital.net>, Arnd Bergmann <arnd@arndb.de>, Casey Schaufler <casey@schaufler-ca.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, James Morris <jmorris@namei.org>, Jann Horn <jann@thejh.net>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Michael Kerrisk <mtk.manpages@gmail.com>, =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mickael.salaun@ssi.gouv.fr>, "Serge E . Hallyn" <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>, Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>, kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-security-module@vger.kernel.org, x86@kernel.or
List-Id: linux-arch.vger.kernel.org


On 25/02/2020 19:49, J Freyensee wrote:
> 
> 
> On 2/24/20 8:02 AM, Mickaël Salaün wrote:
> 
>> ## Syscall
>>
>> Because it is only tested on x86_64, the syscall is only wired up for
>> this architecture.  The whole x86 family (and probably all the others)
>> will be supported in the next patch series.
> General question for u.  What is it meant "whole x86 family will be
> supported".  32-bit x86 will be supported?

Yes, I was referring to x86_32, x86_64 and x32, but all architectures
should be supported.
