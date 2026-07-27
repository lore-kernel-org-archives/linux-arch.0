Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0038D374E55;
	Mon, 27 Jul 2026 20:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785185848; cv=none; b=NV2yjtoi/D86TQXqfcBNtErFB6N/P0uMU3voC3pdHT1RtzvfC3+wIBfKK0SYZ3oaQswfOFCpyBd6jzZbhHNZEbZ6/jh3OUwv5sg0eF7g/OF8gs5FrdlWGeBabm2agEj1VRNm1eClXOnx70s2+be8k2abzTjp9dfuy/4KXUOqglQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785185848; c=relaxed/simple;
	bh=E/ZqZN1a5pDS6ke7YnJYJ964a+YrenxjClQEZrnMCmU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=X8ITkk9q4eTeAPG29GTsmESSY1t8nFUVLiHrneegxF22j95ksFnQCAMP+G8klTozXCiR1VewABm5Nj+DeRFkniJkSkw6F9qFo2RchiTJXK7QzmF+cRZ3O9RtZczhvjgPEwGbtKRzmmWZJfDfmOqlPeT0wkF+G6zZBWjqldqNisw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=yKFKCEZf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="yKFKCEZf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3423B1F000E9;
	Mon, 27 Jul 2026 20:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1785185846;
	bh=OF5Uf3cVWn7wLKnpneETbEEB1Qpfc2UL504RaB7hyhw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=yKFKCEZf6F5mJkslJWLI/BlA6of6bYyu6IrjDON3svjBxhluUoCQFFes1u3EUDPGx
	 iXttUtdwG9rBUBO6AKyOMQuyzMTyXI7xEXOiEFxgJM2XTLzQiinZxTY3G2sVgh5nms
	 PlKsTh5NGicxZ5Gvcs4UIqaUus7cwp/avHOO2XLI=
Date: Mon, 27 Jul 2026 13:57:25 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Li Zhe" <lizhe.67@bytedance.com>
Cc: <apopple@nvidia.com>, <arnd@arndb.de>, <balbirs@nvidia.com>,
 <bp@alien8.de>, <dave.hansen@linux.intel.com>, <david@kernel.org>,
 <kees@kernel.org>, <mingo@redhat.com>, <muchun.song@linux.dev>,
 <rppt@kernel.org>, <tglx@kernel.org>, <linux-arch@vger.kernel.org>,
 <linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-mm@kvack.org>, <x86@kernel.org>
Subject: Re: [PATCH v8 0/9] mm: optimize zone-device memmap initialization
Message-Id: <20260727135725.694139f5ecad67752b0985d0@linux-foundation.org>
In-Reply-To: <20260727123429.5673-1-lizhe.67@bytedance.com>
References: <20260727123429.5673-1-lizhe.67@bytedance.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Jul 2026 20:34:20 +0800 "Li Zhe" <lizhe.67@bytedance.com> wrote:

> memmap_init_zone_device() can take a noticeable amount of time when large
> pmem namespaces are bound or rebound, because it initializes nearly
> identical struct page descriptors one PFN at a time. This series reduces
> that ZONE_DEVICE memmap initialization overhead by reusing prepared
> struct page templates and, on x86, using memcpy_nontemporal() for the
> template copy path.

Thanks.

Human review started out strong but petered out later in the series. 
This often happens.  I'd prefer to wait until it fills out further.

AI review had things to say, as it often does:
	https://sashiko.dev/#/patchset/20260727123429.5673-1-lizhe.67@bytedance.com

