From: Mark Salter <msalter@redhat.com>
Subject: Re: [PATCH] Kconfig cleanup (PARPORT_PC dependencies)
Date: Thu, 12 Sep 2013 15:19:44 -0400
Message-ID: <1379013584.14495.4.camel@deneb.redhat.com>
References: <1379012038-31764-1-git-send-email-msalter@redhat.com>
	 <52321022.6060907@tilera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <52321022.6060907@tilera.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Metcalf <cmetcalf@tilera.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Thu, 2013-09-12 at 15:04 -0400, Chris Metcalf wrote:
> On 9/12/2013 2:53 PM, Mark Salter wrote:
> > Remove messy dependencies from PARPORT_PC by having it depend on one
> > Kconfig symbol (ARCH_MAY_HAVE_PC_PARPORT) and having architectures
> > which need it declare ARCH_MAY_HAVE_PC_PARPORT in arch/*/Kconfig.
> > New architectures are unlikely to need PARPORT_PC, so this avoids
> > having an ever growing list of architectures to exclude. Those
> > architectures which do declare ARCH_MAY_HAVE_PC_PARPORT in this
> > patch are the ones which have an asm/parport.h.
> >
> > Signed-off-by: Mark Salter <msalter@redhat.com>
> 
> You can actually omit the arch/tile change, since as far as I know there's no way for tile to have PARPORT_PC.
> 

Yeah, I thought that the list of architectures in the patch would end up
being a superset of what was really needed. Especially for those which
used the generic parport.h. I can drop tile from this patch but you may
want to get rid of the parport.h from arch/tile/include/asm/Kbuild.
