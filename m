From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [2.6 patch] remove dummy asm/kvm.h files
Date: Wed, 2 Jul 2008 09:38:50 +0200
Message-ID: <200807020938.50194.borntraeger@de.ibm.com>
References: <20080701162716.GB32598@cs181140183.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20080701162716.GB32598@cs181140183.pp.htv.fi>
Content-Disposition: inline
Sender: kvm-owner@vger.kernel.org
To: Adrian Bunk <bunk@kernel.org>
Cc: Avi Kivity <avi@qumranet.com>, linux-arch@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>, David Woodhouse <dwmw2@infradead.org>
List-Id: linux-arch.vger.kernel.org

Am Dienstag, 1. Juli 2008 schrieb Adrian Bunk:
> This patch removes the dummy asm/kvm.h files on architectures not (yet) 
> supporting KVM and uses the same conditional headers installation as
> already used for a.out.h .
> 
> Also removed are superfluous install rules in the s390 and x86 Kbuild 
> files (they are already in Kbuild.asm).
> 
> Signed-off-by: Adrian Bunk <bunk@kernel.org>

Seems to work on s390, ppc and arm as expected.
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
