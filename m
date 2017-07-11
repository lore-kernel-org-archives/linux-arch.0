Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:42073 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933119AbdGKOpz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 11 Jul 2017 10:45:55 -0400
Subject: Re: [PATCH] tty: Fix TIOCGPTPEER ioctl definition
References: <20170711001207.GA11642@glebfm.cloud.tilaa.com>
 <063D6719AE5E284EB5DD2968C1650D6DD003758C@AcuExch.aculab.com>
From: Aleksa Sarai <asarai@suse.de>
Message-ID: <a99e301b-05d1-d262-aca2-60e3f3400bc5@suse.de>
Date: Wed, 12 Jul 2017 00:45:36 +1000
MIME-Version: 1.0
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DD003758C@AcuExch.aculab.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Laight <David.Laight@ACULAB.COM>, 'Gleb Fotengauer-Malinovskiy' <glebfm@altlinux.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>, Valentin Rothberg <vrothberg@suse.com>, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>, "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Dmitry V. Levin" <ldv@altlinux.org>, Jiri Slaby <jslaby@suse.com>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, Christian Brauner <christian.brauner@ubuntu.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Message-ID: <20170711144536.QohDvStXWDfSVsdex6Cj33LQ4ZPgQGsuJhk8nt2BlyA@z>

>> Sent: 11 July 2017 01:12
>> This ioctl does nothing to justify an _IOC_READ or _IOC_WRITE flag
>> because it doesn't copy anything from/to userspace to access the
>> argument.
>>
>> Fixes: 54ebbfb1 ("tty: add TIOCGPTPEER ioctl")
> ...
>> -#define TIOCGPTPEER	_IOR('T', 0x41, int) /* Safely open the slave */
>> +#define TIOCGPTPEER	_IO('T', 0x41) /* Safely open the slave */
> 
> This is a user API change. When was the ioctl added?

It was just pulled this merge window (4.13-rc1).

  % git tag --contains 54ebbfb1603415d9953c150535850d30609ef077
  %

-- 
Aleksa Sarai
Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/
