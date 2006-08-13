Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:52711 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030194AbWHMEsm (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sun, 13 Aug 2006 00:48:42 -0400
From: Andi Kleen <ak@suse.de>
Subject: module compiler version check still needed?
Date: Sun, 13 Aug 2006 06:48:36 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608130648.36178.ak@suse.de>
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


Does anybody know of any reason why we would still need the compiler version
check during module loading? AFAIK on i386 it was only needed to handle
2.95 (which got dropped) and on x86-64 it was never needed. Is there
a need on any other architecture for it?

-Andi
