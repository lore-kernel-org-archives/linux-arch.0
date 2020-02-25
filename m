Return-Path: <SRS0=ZEfg=4N=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44042 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730634AbgBYSt5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Feb 2020 13:49:57 -0500
Subject: Re: [RFC PATCH v14 00/10] Landlock LSM
References: <20200224160215.4136-1-mic@digikod.net>
From: J Freyensee <why2jjj.linux@gmail.com>
Message-ID: <6df3e6b1-ffd1-dacf-2f2d-7df8e5aca668@gmail.com>
Date: Tue, 25 Feb 2020 10:49:52 -0800
MIME-Version: 1.0
In-Reply-To: <20200224160215.4136-1-mic@digikod.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>, linux-kernel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@amacapital.net>, Arnd Bergmann <arnd@arndb.de>, Casey Schaufler <casey@schaufler-ca.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, James Morris <jmorris@namei.org>, Jann Horn <jann@thejh.net>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Michael Kerrisk <mtk.manpages@gmail.com>, =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mickael.salaun@ssi.gouv.fr>, "Serge E . Hallyn" <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>, Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>, kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-security-module@vger.kernel.org, x86@kernel.org
Message-ID: <20200225184952.C1MKnHMGEFPdXRLQyh-SbiiZuZWHmXSHoXbYEUsAPvk@z>



On 2/24/20 8:02 AM, Mickaël Salaün wrote:

> ## Syscall
>
> Because it is only tested on x86_64, the syscall is only wired up for
> this architecture.  The whole x86 family (and probably all the others)
> will be supported in the next patch series.
General question for u.  What is it meant "whole x86 family will be 
supported".  32-bit x86 will be supported?

Thanks,
Jay
