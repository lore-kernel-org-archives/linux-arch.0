From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/19] untangling do_mremap(), part 1
Date: Sat, 12 Dec 2009 20:31:35 +0100
Message-ID: <20091212193134.GD1308@ucw.cz>
References: <E1NHUdk-0007ul-Oc@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933994AbZLMBmV@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <E1NHUdk-0007ul-Oc@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-arch@vger.kernel.org, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Hi!

> Take locating vma and checks on it to a separate helper (it will be
> shared between MREMAP_FIXED/non-MREMAP_FIXED cases when we split
> them in the next patch)

> +static struct vm_area_struct *vma_to_resize(unsigned long addr,
> +	unsigned long old_len, unsigned long new_len, unsigned long *p)
> +{
> +	struct mm_struct *mm = current->mm;
> +	struct vm_area_struct *vma = find_vma(mm, addr);
> +
> +	if (!vma || vma->vm_start > addr)
> +		goto Efault;
> +
> +	if (is_vm_hugetlb_page(vma))
> +		goto Einval;
> +
> +	/* We can't remap across vm area boundaries */
> +	if (old_len > vma->vm_end - addr)
> +		goto Efault;
...
> +Efault:	/* very odd choice for most of the cases, but... */
> +	return ERR_PTR(-EFAULT);
> +Einval:
> +	return ERR_PTR(-EINVAL);
> +Enomem:
> +	return ERR_PTR(-ENOMEM);
> +Eagain:
> +	return ERR_PTR(-EAGAIN);
> +}

Could we just do returns directly, w/o the gotos? In this case I do
not think goto has advantages, as there's no cleanup to do...

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
