Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S261218AbUKSCRo@vger.kernel.org>
Received: from fmr02.intel.com ([192.55.52.25]:33762 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S262870AbUKRSkA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 18 Nov 2004 13:40:00 -0500
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [patch] sys_stime needs a compat function.
Date: Thu, 18 Nov 2004 10:39:30 -0800
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F02681304@scsmsx401.amr.corp.intel.com>
From: "Luck, Tony" <tony.luck@intel.com>
To: Arnd Bergmann <arnd@arndb.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

>>  ia64 doesn't support sys_stime
>
>I'd call that a bug, too.

Just planning ahead.  Letting 32-bit programs set the time
will be a problem in 2038 when 32-bit time wraps :-)

-Tony
