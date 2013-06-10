From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] arch: asm-geniric: for atomic_set_mask() 1st param, use
 'unsigned int' instead of 'unsigned long'
Date: Mon, 10 Jun 2013 11:00:53 -0600
Message-ID: <CAErSpo57_4SnE0_UwNvRc-M2+JvHmpiYTpQE2rAFUXuBEopvFA@mail.gmail.com>
References: <51B2E262.3030603@asianux.com> <CAErSpo5pg0EvJOR9nn3B0d+q0o6zsdwzM41AQx=AHfynRqX3hQ@mail.gmail.com>
 <51B3DFCF.1010509@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:50841 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753529Ab3FJRBN (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jun 2013 13:01:13 -0400
Received: by mail-ob0-f177.google.com with SMTP id ta17so10543425obb.36
        for <linux-arch@vger.kernel.org>; Mon, 10 Jun 2013 10:01:13 -0700 (PDT)
In-Reply-To: <51B3DFCF.1010509@asianux.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chen Gang <gang.chen@asianux.com>
Cc: Mike Frysinger <vapier@gentoo.org>, takata@linux-m32r.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Arnd Bergmann <arnd@arndb.de>, realmz paranoid <realmz6@gmail.com>, linux390@de.ibm.com, "uclinux-dist-devel@blackfin.uclinux.org" <uclinux-dist-devel@blackfin.uclinux.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-m32r@ml.linux-m32r.org, linux-m32r-ja@ml.linux-m32r.org, linux-s390@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>

On Sat, Jun 8, 2013 at 7:52 PM, Chen Gang <gang.chen@asianux.com> wrote:
> On 06/09/2013 01:49 AM, Bjorn Helgaas wrote:
>> s/geniric/generic/ in subject
>>
>
> Could you provide more details information ?

In your subject line, "geniric" is spelled incorrectly.  The correct
spelling is "generic."
