Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oa0-f45.google.com ([209.85.219.45]:60597 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752241Ab3FHRte (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 8 Jun 2013 13:49:34 -0400
Received: by mail-oa0-f45.google.com with SMTP id j6so4440684oag.18
        for <linux-arch@vger.kernel.org>; Sat, 08 Jun 2013 10:49:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <51B2E262.3030603@asianux.com>
References: <51B2E262.3030603@asianux.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Sat, 8 Jun 2013 11:49:14 -0600
Message-ID: <CAErSpo5pg0EvJOR9nn3B0d+q0o6zsdwzM41AQx=AHfynRqX3hQ@mail.gmail.com>
Subject: Re: [PATCH] arch: asm-geniric: for atomic_set_mask() 1st param, use
 'unsigned int' instead of 'unsigned long'
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chen Gang <gang.chen@asianux.com>
Cc: Mike Frysinger <vapier@gentoo.org>, takata@linux-m32r.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Arnd Bergmann <arnd@arndb.de>, realmz paranoid <realmz6@gmail.com>, linux390@de.ibm.com, "uclinux-dist-devel@blackfin.uclinux.org" <uclinux-dist-devel@blackfin.uclinux.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-m32r@ml.linux-m32r.org, linux-m32r-ja@ml.linux-m32r.org, linux-s390@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>
Message-ID: <20130608174914.eeHhvmZcCsRlKposRfBiFiFNg8EeNWDR7eq3ilmJ2F8@z>

s/geniric/generic/ in subject
