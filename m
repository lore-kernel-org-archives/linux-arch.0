From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: [RFC PATCH v1 05/40] Revert some of "binfmt_elf: cleanups"
Date: Thu, 1 Nov 2012 14:25:31 +0100
Message-ID: <20626.30795.679924.702597@pilspetsen.it.uu.se>
References: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com>
	<1351700061-7203-6-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <1351700061-7203-6-git-send-email-james.hogan@imgtec.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: James Hogan <james.hogan@imgtec.com>
Cc: linux-arch@vger.kernel.org, Mikael Pettersson <mikpe@it.uu.se>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

James Hogan writes:
 > The commit "binfmt_elf: cleanups"
 > (f670d0ecda73b7438eec9ed108680bc5f5362ad8) removed an ifndef elf_map but
 > this breaks compilation on metag architecture which does define elf_map.
 > 
 > This adds the ifndef back in as it was before, but does not affect the
 > other cleanups made by that patch.

Since this is part of your patch submission to upstream the metag
kernel support, I have no objection to reverting this fragment of
my patch if/when the metag code gets upstreamed.

Acked-by: Mikael Pettersson <mikpe@it.uu.se>

 > 
 > Signed-off-by: James Hogan <james.hogan@imgtec.com>
 > Cc: Mikael Pettersson <mikpe@it.uu.se>
 > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
 > Cc: linux-fsdevel@vger.kernel.org
 > ---
 >  fs/binfmt_elf.c |    4 ++++
 >  1 files changed, 4 insertions(+), 0 deletions(-)
 > 
 > diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
 > index 1b52956..14d1fbd 100644
 > --- a/fs/binfmt_elf.c
 > +++ b/fs/binfmt_elf.c
 > @@ -314,6 +314,8 @@ create_elf_tables(struct linux_binprm *bprm, struct elfhdr *exec,
 >  	return 0;
 >  }
 >  
 > +#ifndef elf_map
 > +
 >  static unsigned long elf_map(struct file *filep, unsigned long addr,
 >  		struct elf_phdr *eppnt, int prot, int type,
 >  		unsigned long total_size)
 > @@ -348,6 +350,8 @@ static unsigned long elf_map(struct file *filep, unsigned long addr,
 >  	return(map_addr);
 >  }
 >  
 > +#endif /* !elf_map */
 > +
 >  static unsigned long total_mapping_size(struct elf_phdr *cmds, int nr)
 >  {
 >  	int i, first_idx = -1, last_idx = -1;
 > -- 
 > 1.7.7.6
 > 
 > 
