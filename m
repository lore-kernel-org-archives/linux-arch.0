From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 0/3] namei: implement various scoping AT_* flags
Date: Mon, 1 Oct 2018 14:08:21 +1000
Message-ID: <20181001040821.GP31060@dastard>
References: <20180929103453.12025-1-cyphar@cyphar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180929103453.12025-1-cyphar@cyphar.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Jeff Layton <jlayton@kernel.org>, "J. Bruce Fields" <bfields@fieldses.org>, Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>, David Howells <dhowells@redhat.com>, Andy Lutomirski <luto@kernel.org>, Christian Brauner <christian@brauner.io>, Eric Biederman <ebiederm@xmission.com>, Tycho Andersen <tycho@tycho.ws>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, dev@opencontainers.org, containers@lists.linux-foundation.org
List-Id: linux-arch.vger.kernel.org

On Sat, Sep 29, 2018 at 08:34:50PM +1000, Aleksa Sarai wrote:
> I've added some selftests for this, but it's not clear to me whether
> they should live here or in xfstests (as far as I can tell there are no
> other VFS tests in selftests, while there are some tests that look like
> generic VFS tests in xfstests). If you'd prefer them to be included in
> xfstests, let me know.

xfstests, please. That way the new functionality will get immediate
coverage by all the main filesystem development and distro QA
teams....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
