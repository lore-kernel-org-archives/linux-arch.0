From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH v2] mm/highmem: make kmap cache coloring aware
Date: Mon, 21 Jul 2014 18:20:07 -0700 (PDT)
Message-ID: <alpine.DEB.2.02.1407211819340.9778@chino.kir.corp.google.com>
References: <1405616598-14798-1-git-send-email-jcmvbkbc@gmail.com> <alpine.DEB.2.02.1407211754350.7042@chino.kir.corp.google.com> <53CDBB01.7040007@imgtec.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <53CDBB01.7040007@imgtec.com>
Sender: owner-linux-mm@kvack.org
To: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Cc: Max Filippov <jcmvbkbc@gmail.com>, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-mips@linux-mips.org, linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Mon, 21 Jul 2014, Leonid Yegoshin wrote:

> Yes, there is one, at least for MIPS. This stuff can be a common ground for
> both platforms (MIPS and XTENSA)
> 

Needs the mips patch as a followup as justification for the change.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
