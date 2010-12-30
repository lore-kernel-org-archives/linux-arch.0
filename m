From: Christoph Paasch <christoph.paasch@uclouvain.be>
Subject: Compilation of pktgen fails for ARCH=um
Date: Thu, 30 Dec 2010 11:33:14 +0100
Message-ID: <201012301133.14524.christoph.paasch@uclouvain.be>
Reply-To: christoph.paasch@uclouvain.be
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.sgsi.ucl.ac.be ([130.104.5.67]:33712 "EHLO
	smtp3.sgsi.ucl.ac.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752799Ab0L3Kmp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 30 Dec 2010 05:42:45 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: netdev@vger.kernel.org
Cc: linux-arch@vger.kernel.org

Hi,

compiling the packet generator (NET_PKTGEN) for ARCH=3Dum does not work=
=2E

Since commit 43d28b6515a6ea580a198df3e253e88236f08978 (pktgen: increasi=
ng=20
transmission granularity), function spin(...) uses ndelay(...), which i=
s not=20
implemented for uml.

Should pktgen be disabled for uml?
Or should ndelay be an empty macro? (in arch/um/include/asm/delay.h)

Regards,
Christoph

--
Christoph Paasch

Research Assistant
IP Networking Lab --- http://inl.info.ucl.ac.be
MultiPath TCP in the Linux Kernel --- http://inl.info.ucl.ac.be/mptcp
Universit=E9 Catholique de Louvain

www.rollerbulls.be
--
