Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:57761 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933345Ab1JDSGb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 4 Oct 2011 14:06:31 -0400
Date: Tue, 4 Oct 2011 20:06:29 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v4 12/24] C6X: interrupt handling
In-Reply-To: <1317746641-26725-13-git-send-email-msalter@redhat.com>
Message-ID: <alpine.LFD.2.02.1110042005370.18778@ionos>
References: <1317746641-26725-1-git-send-email-msalter@redhat.com> <1317746641-26725-13-git-send-email-msalter@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Salter <msalter@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Aurelien Jacquiot <a-jacquiot@ti.com>, Grant Likely <grant.likely@secretlab.ca>
Message-ID: <20111004180629.-cceksZPH3750qpQMBSkDyum0w-gY_wZVrFIyWWqAyQ@z>

On Tue, 4 Oct 2011, Mark Salter wrote:

> From: Aurelien Jacquiot <a-jacquiot@ti.com>
> 
> Original port to early 2.6 kernel using TI COFF toolchain.
> Brought up to date by Mark Salter <msalter@redhat.com>
> 
> Signed-off-by: Aurelien Jacquiot <a-jacquiot@ti.com>
> Signed-off-by: Mark Salter <msalter@redhat.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de> - who hopes that we
can get rid of that copied around code ASAP

