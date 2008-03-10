Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.174]:59144 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752586AbYCJLXl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 10 Mar 2008 07:23:41 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] kvm: provide kvm.h for all architecture: fixes headers_install
Date: Mon, 10 Mar 2008 12:23:02 +0100
References: <200803071326.06682.borntraeger@de.ibm.com> <1204933418.2495.14.camel@shinybook.infradead.org> <200803100913.46422.borntraeger@de.ibm.com>
In-Reply-To: <200803100913.46422.borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-ID: <200803101223.03712.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Woodhouse <dwmw2@infradead.org>, Avi Kivity <avi@qumranet.com>, Sam Ravnborg <sam@ravnborg.org>, kvm-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20080310112302.3KGoQebyeR9L85zbNOoQS1oYjclTueH2-pWjA06gsWQ@z>

On Monday 10 March 2008, Christian Borntraeger wrote:
>  include/asm-alpha/Kbuild     |    1 +
>  include/asm-alpha/kvm.h      |    6 ++++++
>  include/asm-arm/Kbuild       |    2 ++
>  include/asm-arm/kvm.h        |    6 ++++++
>  include/asm-avr32/Kbuild     |    1 +
>  include/asm-avr32/kvm.h      |    6 ++++++
>  include/asm-blackfin/Kbuild  |    1 +
>  include/asm-blackfin/kvm.h   |    6 ++++++
>  include/asm-cris/Kbuild      |    1 +
>  include/asm-cris/kvm.h       |    6 ++++++
>  include/asm-frv/Kbuild       |    1 +
>  include/asm-frv/kvm.h        |    6 ++++++
>  include/asm-h8300/Kbuild     |    2 ++
>  include/asm-h8300/kvm.h      |    6 ++++++
>  include/asm-ia64/Kbuild      |    1 +
>  include/asm-ia64/kvm.h       |    6 ++++++
>  include/asm-m32r/Kbuild      |    2 ++
>  include/asm-m32r/kvm.h       |    6 ++++++
>  include/asm-m68k/Kbuild      |    1 +
>  include/asm-m68k/kvm.h       |    6 ++++++

Instead of adding kvm.h to every single Kbuild file, you can
just add it once, in include/asm-generic/Kbuild.asm.

	Arnd <><
