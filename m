From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 0/3] namei: implement various scoping AT_* flags
Date: Sat, 29 Sep 2018 12:44:29 -0700
Message-ID: <20180929194429.GA1702@bombadil.infradead.org>
References: <20180929103453.12025-1-cyphar@cyphar.com>
 <1EE20CA2-4C8B-4A80-B613-0277D92B376D@amacapital.net>
 <20180929154551.jsi6dt3xjxdxoqeh@ryuk>
 <9D01A225-05BE-4B4A-873A-94168D17F687@amacapital.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9D01A225-05BE-4B4A-873A-94168D17F687@amacapital.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: Aleksa Sarai <cyphar@cyphar.com>, Jeff Layton <jlayton@kernel.org>, "J. Bruce Fields" <bfields@fieldses.org>, Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>, David Howells <dhowells@redhat.com>, Andy Lutomirski <luto@kernel.org>, Christian Brauner <christian@brauner.io>, Eric Biederman <ebiederm@xmission.com>, Tycho Andersen <tycho@tycho.ws>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, dev@opencontainers.org, containers@lists.linux-foundation.org
List-Id: linux-arch.vger.kernel.org

On Sat, Sep 29, 2018 at 09:34:24AM -0700, Andy Lutomirski wrote:
> Also, as a perhaps-silly suggestion: if you end up adding a new
> syscall, I can see a use for a mode that does the path walk but, rather
> than failing on a disallowed link, stops early and indicates where it
> stopped. Then web servers, samba, etc can more efficiently implement
> custom behavior when links are encountered.  And it may also be useful
> to have a variant of AT_THIS_ROOT where trying to escape is an error
> instead of having it just get stuck at the root.

AT_USER_LINKS indicating that userspace wants to resolve symlinks
themselves?
